FVANG
=======

### Flask-Vagrant-Ansible-Nginx-Gunicorn *Starter Pack*

##### Getting started

0. Install [Vagrant](https://www.vagrantup.com/)

0. Clone this repo to your project folder

0. Modify your local ```/etc/hosts``` to include this entry:

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

    ### OR USING ANY SSH CLIENT ###
    host: fvang.local
    user: vagrant
    pass: vagrant
    ```

0. Start development server:
    ```sh
    ### FLASK ###
    cd ~/fvang
    python fvang/app.py

    ### DJANGO ###
    cd ~/fvang
    python fvang/manage.py runserver 0.0.0.0:80
    ```

0. Profit :heavy_check_mark:
