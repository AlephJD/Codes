import sqlite3  # imports the python buit-in library

# Connect to the database
conn = sqlite3.connect('emaildb.sqlite') # 1st open: make the connection to the database that checks access to the file # builds the object (creates it)

# Create a cursor object
cur = conn.cursor()  # 2nd open: kind of a handle, sendig sql commands to the cursor (object that allows interact with a database)

# Execute a query
cur.execute('DROP TABLE IF EXISTS Counts')  # if already exists, drop the table and start fresh

cur.execute('''
CREATE TABLE Counts (email TEXT, count INTEGER)''') # create the table

fname = input('Enter file name: ')  # get a filename
if (len(fname) < 1): fname = 'mbox-short.txt'
fh = open(fname)
for line in fh:
    if not line.startswith('From: '): continue
    pieces = line.split()
    email = pieces[1]
    cur.execute('SELECT count FROM Counts WHERE email = ? ', (email,))  # 'dictionary' part
    row = cur.fetchone()    # 'dictionary' part
    if row is None: # 'dictionary' part
        cur.execute('''INSERT INTO Counts (email, count)    
                VALUES (?, 1)''', (email,)) # 'dictionary' part
    else:   # 'dictionary' part
        cur.execute('UPDATE Counts SET count = count + 1 WHERE email = ?',
                    (email,))   # 'dictionary' part
    conn.commit()   # database keeps some information in memory, and has to write out disk all that. We can commit every 10th or 100th record

# https://www.sqlite.org/lang_select.html
sqlstr = 'SELECT email, count FROM Counts ORDER BY count DESC LIMIT 10'

for row in cur.execute(sqlstr):
    print(str(row[0]), row[1])

# Close the cursor
cur.close()

# Should be a "close connection"?
