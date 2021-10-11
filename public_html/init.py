from flask import Flask, render_template, request, redirect

app=Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'POST' and 'UserName' in request.form and 'Password' in request.form:
        return redirect("http://www.google.com/", code=302)
    return render_template("index.html")