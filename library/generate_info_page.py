#!/usr/bin/python
from __future__ import annotations

from ansible.module_utils.basic import AnsibleModule



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

    html = ""
    for h in hosts:
        html += f"{h}, {hostvars[h]['ip'] if 'ip' in hostvars[h] else 'no ip'}, {hostvars[h]['mac'] if 'mac' in hostvars[h] else 'no mac'}"

    module.exit_json(
        changed=True, html=html
    )


if __name__ == "__main__":
    main()
