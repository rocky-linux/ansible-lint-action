FROM python:3.8-slim

LABEL "maintainer"="The Rocky Linux Project <infrastructure@rockylinux.org>"
LABEL "repository"="https://github.com/rocky-linux/ansible-lint-action"
LABEL "homepage"="https://github.com/rocky-linux/ansible-lint-action"

LABEL "com.github.actions.name"="ansible-lint"
LABEL "com.github.actions.description"="Run Ansible Lint"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="gray-dark"

# Install git (required by ansible-lint)
RUN set -ex && apt-get update && apt-get -q install -y -V git && rm -rf /var/lib/apt/lists/*

RUN pip install ansible-lint


COPY infrastructure/ansible/roles/requirements.yml /requirements.yml
RUN ansible-galaxy role install -r /requirements.yml
RUN ansible-galaxy collection install -r /requirements.yml

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
