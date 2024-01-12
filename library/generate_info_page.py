#!/usr/bin/python
from __future__ import annotations

from collections import OrderedDict

from ansible.module_utils.basic import AnsibleModule


def main():
    module_args = dict(
        hostvars=dict(type="dict", required=True),
        hosts=dict(type="list", required=True),
    )
    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    hostvars = module.params["hostvars"]
    hosts = module.params["hosts"]

    html = ("<table >"
            "<tr>"
            "<th>NAME</th>"
            "<th>IP</th>"
            "<th>MAC</th>"
            "</tr>")
    data = {}
    for h in hosts:
        if "ip" in hostvars[h] and 'mac' in hostvars[h]:
            data[hostvars[h]['ip'].split(".")[3]] = f"<tr><td>{h}</td><td>{hostvars[h]['ip']}</td><td>{hostvars[h]['mac']}</td></<tr>"
    data = OrderedDict(sorted(data.items()))
    for nr in range(100,255):
        if str(nr) in data:
            html += data[str(nr)]
        else: 
            html += f"<tr><td></td><td>192.168.1.{nr}</td><td></td></<tr>"

    html += "</table>"
    module.exit_json(
        changed=True, html=html
    )


if __name__ == "__main__":
    main()
