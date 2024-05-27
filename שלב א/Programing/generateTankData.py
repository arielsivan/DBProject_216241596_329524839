import random

def generate_tank_data(num_records):
    data = []
    for x in range(num_records):
        id = x
        cid = x
        unid = random.randrange(1,250) # getting the id of the unit
        data.append((id,cid, unid))
    return data

def generate_sql_insert_statements(table_name, data):
    sql_statements = []
    for record in data:
        sql = f"INSERT INTO {table_name} (TID, CID, UNID) VALUES ({record[0]},{record[1]},{record[2]});"
        sql_statements.append(sql)
    return sql_statements

# Generate data
num_records = 350  # Number of records we want to generate
tank_data = generate_tank_data(num_records)

# Generate SQL insert statements
sql_statements = generate_sql_insert_statements('TANK', tank_data)
