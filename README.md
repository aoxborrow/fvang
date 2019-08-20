FVANG
=======

### Flask-Vagrant-Ansible-Nginx-Gunicorn *Starter Pack*

This is a starter pack for quickly developing a new Flask project locally with Vagrant, which is then easily deployed into production with Ansible. It installs and configures all the services you'll need:
 - **Vagrant** VM based on **Ubuntu 18.04**
 - **Python 3.6** virtualenv for your **Flask** app and its dependencies
 - **Nginx** to serve static files and proxy to **Gunicorn**
 - **Supervisor** to automatically start/restart Gunicorn
 - **Node.js** for installing front-end components *(optional)*

### Features
- Disposable environment is fully self-contained within the Vagrant VM
- Ansible playbooks for both local development and production
- Develop with Flask dev server, then test/deploy with Gunicorn/Nginx
- Easily add Ansible galaxy roles *(ansible/requirements.yml)*
- Activates Python virtualenv on login
- Installs Python packages from `requirements.txt`
- Installs Node packages from `package.json`

### Shortcuts
- `activate` - activate the virtualenv 
- `deactivate` - deactivate the virtualenv 
- `make run` - run Flask development server 
- `make restart` - start/restart Gunicorn & Nginx
- `make provision-dev` - run playbook for dev *(must deactivate virtualenv)*
- `make provision-prod` - run playbook production *(must deactivate virtualenv)*
----

### Local Development

0. Install [Vagrant](https://www.vagrantup.com/)

0. Clone this repo as your project name: **(This is important, the project folder name will be used for configuring hostname, etc.)**
    ```sh
    git clone git@github.com:paste/fvang.git my-project-name
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
    cd my-project-name
    make run
    ```

0. Modify your computer's local `/etc/hosts`:

    ```
    192.168.33.11   my-project-name.local
    ```

0. Visit your app:
    ```
    http://my-project-name.local
    ```


0. **Profit** :heavy_check_mark:


----

### In Production

0. You'll need a remote user with `sudo` privileges to run Ansible.

0. Edit the `host_name` and other settings in `ansible/prod.yml` as necessary.

0. Clone your project onto the server in your remote user's home folder, e.g. `~/my-project-name`

0. Install Ansible with the included script:
    ```sh
    cd ~/my-project-name
    sudo ansible/install.sh
    ```

0. Install Ansible Galaxy roles:
    ```sh
    make install-galaxy-roles
    ```

0. Run the Ansible production playbook:
    ```sh
    make provision-prod
    ```

0. **Profit** :heavy_check_mark:


----

### HTTPS in Production

0. To use HTTPS you will need an SSL certificate. Get one from Certbot here: https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx

0. Copy the certificate and key to your remote user's home folder. The Nginx configuration expects the files to be named after the `host_name`, like this:  
    ```
    ~/fvang.io.crt
    ~/fvang.io.key
    ```

0. Update the production playboook to use SSL, in `ansible/prod.yml`:  
    ```yaml
    nginx_use_ssl: true
    ```

0. Re-run the Ansible production playbook:
    ```sh
    make provision-prod
    ```

0. **Profit** :heavy_check_mark:
