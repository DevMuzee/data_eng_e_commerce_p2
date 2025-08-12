import psycopg2
import csv

conn= psycopg2.connect(
        database='e_commerce',
        host= 'dep-little-frog-a18fufg1-pooler.ap-southeast-1.aws.neon.tech',
        user='neondb_owner',
        password= '*****************',
        port=5432
)

cur= conn.cursor()

#importing into existing table created dpg-d20j1hh5pdvs73ck92pg-a.oregon-postgres.render.com

with open('C:/Users/abdulmuiz.adewale/postgresql/e_commerce/data.csv', 'r') as f:
    next(f) #skipping the header
    cur.copy_expert('COPY online_retail FROM STDIN WITH CSV HEADER', f)

conn.commit()
cur.close()
conn.close()

print('csv imported succesfully')
