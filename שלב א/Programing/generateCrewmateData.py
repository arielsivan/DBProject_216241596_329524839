types = ['Loader','Gunner','Driver']

def generate_crewmate_data(num_records):
    data = []
    for x in range(num_records):
        id = x + 601
        cid = int((id - 600) / 4 ) + 1; # getting the id of the commander
        type = types[x % 3 ]
        data.append((id,cid, type))
    return data

def generate_sql_insert_statements(table_name, data):
    sql_statements = []
    for record in data:
        sql = f"INSERT INTO {table_name} (CRID, CID, TYPE) VALUES ({record[0]},{record[1]},{record[2]});"
        sql_statements.append(sql)
    return sql_statements

# Generate data
num_records = 1320  # Number of records we want to generate
crewmate_data = generate_crewmate_data(num_records)

# Generate SQL insert statements
sql_statements = generate_sql_insert_statements('CREWMATE', rewmate_data)
