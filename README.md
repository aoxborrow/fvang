FVANG
=======

### Flask-Vagrant-Ansible-Nginx-Gunicorn *Starter Pack*

#### Description
This is a starter pack for quickly developing a new Flask project locally with Vagrant, which is then easily deployed onto production. It is based on a stock Ubuntu 14.04 base image, and uses Ansible to install and configure the basic services you'll need:
 - A Python virtualenv to house your Flask application and its dependencies
 - Gunicorn to serve your Flask application
 - NGINX to serve static files and proxy to Gunicorn
 - Supervisor to automatically start/restart Gunicorn

#### Features
- fully self-contained, installs Ansible within the VM
- Ansible playbooks for development and production
- develop with Flask debug server, then test/deploy with Gunicorn/NGINX
- easy to add more Ansible roles, e.g. PostgreSQL, MySQL, Redis, etc.
- activates virtualenv on login
- installs packages from `requirements.txt`
- start Gunicorn: `sudo supervisorctl start gunicorn`
- start NGINX: `sudo service nginx start`

----

#### Quick start, developing locally

0. Install [Vagrant](https://www.vagrantup.com/) (Requires 1.8+)

0. Clone this repo:
    ```
    git clone git@github.com:paste/fvang.git
    ```

0. Modify your computer's local `/etc/hosts`:

    ```
    192.168.33.11   fvang.local
    ```

0. Build your Vagrant VM:

    ```sh
    vagrant up
    ```

0. Log into the VM via SSH:
    ```sh
    vagrant ssh
    ```

0. Start Flask development server:
    ```sh
    cd fvang
    python fvang/app.py
    ```

0. **Profit** :heavy_check_mark:

----

#### Changing the project name

0. Clone this repo as your project name:
    ```sh
    git clone git@github.com:paste/fvang.git new-project-name
    ```

0. Rename the app folder:
    ```
    fvang -> new-project-name
    ```

0. Replace any mentions of `fvang` in `Vagrantfile`:
    ```
    /home/vagrant/new-project-name
    ```

0. Configure project name in `ansible/roles/common/vars/main.yml`:
    ```yaml
    project_name: new-project-name
    ```

0. Configure host name in `ansible/roles/nginx/vars/main.yml`:
    ```yaml
    host_name: new-project-name.party
    ```

0. Build your new Vagrant VM:

    ```sh
    vagrant up
    ```

----

#### In production

0. Clone your repo onto the server into your user's home folder, e.g. `/home/ubuntu/fvang`. You will probably need to install and configure your Git client to do this.

0. Install Ansible or try the included Ansible install script:
    ```sh
    ansible/install.sh
    ```

0. Run the Ansible production playbook. It will automatically start Gunicorn and NGINX:
    ```sh
    ansible-playbook -c local ansible/prod.yml
    ```

0. **Profit** :heavy_check_mark:
