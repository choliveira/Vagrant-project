## Project Env Setup

###Create a Vagrant dev box
- Download and Install virtual box https://www.virtualbox.org/wiki/Downloads depending on what S.O are you using.
- Install vagrant https://www.vagrantup.com/downloads.html also select the download based on your S.O

### About this packager

### First of all, this will be your project folder, rename it as you want.

#### The ServerProvision folder:
- bootstrap.sh: This is what will be installed inside of your virtual machine operational system
    - Must have to change the lines 17 & 18 according to your project_name.local.conf
- project_name.local.conf: This is your virtual host to run apache. You must rename it for what you want to access via url
```
mysite.local.conf
```
- provision.rb: must important part is the location which is the root path of your application
```
/var/www/project_name
```

### The Vagrantfile
- This is the proper vagrant setup, the must important bits you should concern are:
 
    - The S.O that will run inside of your virtual machine, change it if you want (check the docs on https://www.vagrantup.com)
    ```
    config.vm.box = "ubuntu/trusty64"
    ```

    - You must have to change (for the desired IP) it if this IP is already in use on your private network.
    ```
    config.vm.network "private_network", ip: "192.168.33.22"
    ```
    
    - Noting else need to be changed on this file. 


### Make it work

- Open you terminal and go to your project path
    assuming it is on Mac, the best practice would be:
    ```
        ~/username/Sites/project_name
    ``` 
- As you are on your project path run the commands bellow:
 
```
vagrant up
vagrant ssh
```

### Set up your hosts file to access this new VM via browser
- On your mac open the file `/etc/hosts` with your preferable editor, your must be sudo(root) to edit this file:
    - include this line:
    ```
    192.168.33.22   project_name.local    
    ```
    - Save and  close
    - go to your browser and open http://project_name.local


#Great job! you have your VM running. Just play around.
