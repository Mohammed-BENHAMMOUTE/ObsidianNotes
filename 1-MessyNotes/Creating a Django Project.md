[[Django]]


1. Create a new Django Project:
``` bash
django-admin startproject blog_project
cd blog_project
```
2. create a new app within your app
```shell
python manage.py startapp blog
```

3. Configure the project:

``` python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'blog',  # Add this line/ her ei sth ename of the project 
]
```
