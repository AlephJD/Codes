from urllib.request import urlopen  # defines functions and classes which help in opening URL's (oauth's mostly)
import urllib.error # provides a way to handle errors that might occur when you're making HTTP request using 'urllib.request'
import twurl # a curl-like app, for Twitter API to retrieve data from a user (oauth certificates)
import json # "JavaScript Object Notation" encode/decode lightweight data-interchange format: Python objects <-> JSON strings
import sqlite3
import ssl  # secure communication over the network

TWITTER_URL = 'https://api.twitter.com/1.1/friends/list.json' # our 'url' to talk to the Twitter API

conn = sqlite3.connect('spider.sqlite') # making a database
cur = conn.cursor() # sendig sql commands to the cursor (object that allows interact with a database)

cur.execute('''
            CREATE TABLE IF NOT EXISTS Twitter
            (name TEXT, retrieved INTEGER, friends INTEGER)''') # creates a table. It will start over and over (restartable process using a database) so we don't lose data. Is a 'spidering' process.

# Ignore SSL certificate errors
ctx = ssl.create_default_context() # creates an 'sslcontext' object with secure default settings. The context ('ctx') is used to establish secure(encrypted) network connections.
ctx.check_hostname = False  # 'False' means is not enable. Controls whether 'hostname' verification is performed during TSL/SSL handshake. It prevents intermediaries attacks. When enabled, the 'ssl' module compares the hostname with the Common Name (CN) or Subject Alternative Name (SAN) in the server's certifite. If the don't mach, an 'ssl.CertificateError' is raised.
ctx.verify_mode = ssl.CERT_NONE # control the level of certificate verification. When set as "CERT_NONE", no certificate verification is performed. This is highly insecure and should be avoided in production environments.

while True:
    acct = input('Enter a Twitter account, or quit: ')  # ask for Twitter account
    if (acct == 'quit'): break  # if you want to quit(exit)
    if (len(acct) < 1): # if you click 'Enter', it's going to read from the database an unretrieved twitter person and grab all that person's friends. We're going to use this line to know about unretrieved
        cur.execute('SELECT name FROM Twitter WHERE retrieved = 0 LIMIT 1')
        try:
            acct = cur.fetchone()[0] # is going to get one row from the database. Sub-zero means the first column of thata first row
        except: # and if this(above) fails...
            print('No unretrieved Twitter accounts found')  # ...we have retrieved all twitter accounts
            continue

    url = twurl.augment(TWITTER_URL, {'screen_name': acct, 'count': '20'}) # The Twitter API requires a developer account, which is not always approved quickly (if it is approved at all). For this line, we're going to use 'twurl','hidden.', 'oauth.' and 'twitter1.''py' 
    print('Retrieving', url)    # print url
    connection = urlopen(url, context=ctx) # retrieves URLs with a variety of protocols. The return value from urlopen() gives access to the headers from the HTTP server
    data = connection.read().decode()   # making sure that [read()] the UTF (Unicode Transformation Format) give data in UTF-8, and decode() give us data in unicode which is what we need in python
    headers = dict(connection.getheaders()) # asking to give a dictionary of the headers from the connection

    print('Remaining', headers['x-rate-limit-remaining'])   # this part tell us when we're going to get told we can't use this API anymore 
    js = json.loads(data)   # parsing and load the data from Twitter. It will give us a list
    # Debugging
    # print json.dumps(js, indent=4) # we can dump the list

    cur.execute('UPDATE Twitter SET retrieved=1 WHERE name = ?', (acct, ))  # retrieving the name from ['screen_name': acct, line 33] and parse it, and Update changing the retrieve from 0 to 1

    countnew = 0
    countold = 0    # going through all the users that are friend of the user account
    for u in js['users']:
        friend = u['screen_name']   # finding the friends screen name
        print(friend)   # printing the screen name
        cur.execute('SELECT friends FROM Twitter WHERE name = ? LIMIT 1',
                    (friend, )) # selecting the friends from Twitter where the name is the friend person 
        try:
            count = cur.fetchone()[0]   # we're going to get friend's screen name and we're going to get how many friends the 'screen name' in 'friend' (line 49 & 52) has
            cur.execute('UPDATE Twitter SET friends = ? WHERE name = ?',
                        (count+1, friend))  # if we find an url we're going to do an update statement and add +1 to the friends count to see how many friends they have
            countold = countold + 1 # this keep a track. This count is not in the databases, so it can be printed at the end
        except:
            cur.execute('''INSERT INTO Twitter (name, retrieved, friends)
                        VALUES (?, 0, 1)''', (friend, ))    # if there's no record in 'friend' [line 49 & 52] we're going to insert them into new 'friend' (line 60, saying here's the new person that we just saw), setting 'retrieve' to zero, and say that they have one friend
            countnew = countnew + 1
    print('New accounts=', countnew, ' revisited=', countold)
    conn.commit()   # commiting the transaction

cur.close() # closing the connection
