#!/usr/bin/python
from __future__ import annotations

from ansible.module_utils.basic import AnsibleModule


def get_rule_id_for_port(rules: list[dict], new_rule: dict) -> int:
    for rule_id, rule in enumerate(rules):
        if new_rule["port"] == rule["port"]:
            return rule_id
    return -1


def get_only_ansible_generated_firewalls(firewall_list):
    filtered_hetzner_firewalls = []
    for firewall in firewall_list:
        firewall_name = firewall["name"]
        if firewall_name.startswith("Ansible"):
            filtered_hetzner_firewalls.append(firewall_name)
    return filtered_hetzner_firewalls


def find_hosts(hostname, filtered_groups):
    for group_name, host_list in filtered_groups.items():
        if hostname in host_list:
            return host_list


def _build_command(name, domain, ttl, ip):
    return f":if ([:put [:len [/ip dns static find name={ name }.{ domain }]]] >0) do={{/ip dns static set [find name={ name }.{ domain }] address={ ip } ttl={ ttl }}} else={{/ip dns static add address={ ip } ttl={ ttl } name={ name }.{ domain }}}"


def build_commands(host_list, domain, ttl, hostvars):
    return [_build_command(host, domain, ttl, hostvars[host]["ip"]) for host in host_list]


def filter_hosts(hosts, hostvars):
    host_list = []
    for host in hosts:
        if "ip" in hostvars[host]:
            host_list.append(host)
    return host_list


def main():
    module_args = dict(
        hostvars=dict(type="dict", required=True),
        hosts=dict(type="list", required=True),
    )
    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    hostvars = module.params["hostvars"]
    hosts = module.params["hosts"]
    mikrotik = hostvars['mikrotik']
    ttl = hostvars['mikrotik']['dns']['ttl']
    domain = hostvars['mikrotik']['dns']['domain']

    filtered_hosts = filter_hosts(hosts, hostvars)

    dns_list = build_commands(filtered_hosts, domain, ttl, hostvars)
    module.exit_json(
        changed=True, list=dns_list
    )


if __name__ == "__main__":
    main()
