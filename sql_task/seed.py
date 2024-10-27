import faker
from random import randint
import sqlite3

NUMBER_USERS = 10
NUMBER_TASKS = 30

def generate_fake_data(number_users, number_tasks) -> tuple:
    fake_users = []
    fake_tasks = []
    fake_data = faker.Faker()

    for _ in range(number_users):
        fake_users.append((fake_data.name(), fake_data.email()))

    for _ in range(number_tasks):
        fake_tasks.append((fake_data.sentence(nb_words=5), fake_data.paragraph(nb_sentences=3)))

    return fake_users, fake_tasks

def prepare_data(users, tasks) -> tuple:
    for_users = []

    for fullname, email in users:
        for_users.append((fullname, email))

    for_tasks = []

    for title, description in tasks:
        for_tasks.append((title, description, randint(1, 3), randint(1, NUMBER_USERS)))

    for_status = [("new",), ("in progress",), ("completed",)]

    return for_users, for_tasks, for_status

def insert_data_to_db(users, tasks, status) -> None:

    with sqlite3.connect('tasks.db') as con:

        cur = con.cursor()

        sql_to_users = """INSERT INTO users(fullname, email)
                               VALUES (?, ?)"""

        cur.executemany(sql_to_users, users)

        sql_to_status = """INSERT INTO status(name)
                              VALUES (?)"""

        cur.executemany(sql_to_status, status)

        sql_to_tasks = """INSERT INTO tasks(title, description, status_id, user_id)
                               VALUES (?, ?, ?, ?)"""

        cur.executemany(sql_to_tasks, tasks)

        con.commit()

if __name__ == "__main__":
    users, tasks, status = prepare_data(*generate_fake_data(NUMBER_USERS, NUMBER_TASKS))
    insert_data_to_db(users, tasks, status)
    