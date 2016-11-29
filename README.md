# gds-infoshare
A simple tool to share information.



Department
- name
- nickname
- engagement manager?
- Has many: contracts
- has_many: initiatives

Contract
- value
- dates
- has_many: products
- belongs_to: department
- belongs_to: supplier

Initiative
- name
- dates
- description
- has_many: deployments
- belongs_to: department
- has_many: contracts

deployments
- cost
- progress (0-1)
- has_many: updates
- has_many: products
- belongs_to: initiative

update
- date
- headline
- owner
- detail
- progress? (float 0-1)
- RAG status? (red, amber, green)


product
- name
- description
- has_many: deployments
- has_many: contracts
