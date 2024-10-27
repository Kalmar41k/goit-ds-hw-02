-- Отримати всі завдання певного користувача.
SELECT * FROM tasks WHERE user_id = 1;

-- Вибрати завдання за певним статусом.
SELECT * FROM tasks WHERE status_id = 3;

-- Оновити статус конкретного завдання.
UPDATE tasks SET status_id = 3 WHERE id = 1;

INSERT INTO users (fullname, email)
VALUES ('John Doe', 'john.gmail.com');

-- Отримати список користувачів, які не мають жодного завдання.
SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM tasks);

-- Додати нове завдання для конкретного користувача.
INSERT INTO tasks (title, description, status_id, user_id)
VALUES ('Clean recycle bin.', 'Open the recycle bin. Click clean recycle bin.', 1, 11);

SELECT * FROM tasks;

-- Отримати всі завдання, які ще не завершено.
SELECT * FROM tasks WHERE status_id != 3;

-- Видалити конкретне завдання.
DELETE FROM tasks WHERE id = 31;

-- Знайти користувачів з певною електронною поштою.
SELECT * FROM users WHERE email LIKE '%.org';

-- Оновити ім'я користувача.
UPDATE users SET fullname = 'Vitalii' WHERE id = 11;

SELECT * FROM users;

-- Отримати кількість завдань для кожного статусу.
SELECT COUNT(id) AS total_tasks, status_id
FROM tasks
GROUP BY status_id;

-- Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти.
SELECT t.id, t.title, t.description, u.fullname, u.email
FROM tasks t
JOIN users u ON u.id = t.user_id
WHERE u.email LIKE '%@example.com';

INSERT INTO tasks (title, status_id, user_id)
VALUES ('Create folder "new-project"', 1, 11);

-- Отримати список завдань, що не мають опису.
SELECT * FROM tasks WHERE description IS NULL;

INSERT INTO users (fullname, email)
VALUES ('John Doe', 'john.exapmle.com');

SELECT * FROM users;

-- Вибрати користувачів та їхні завдання, які є у статусі 'in progress'.
SELECT 
	u.id AS user_id,
    u.fullname,
    u.email,
    t.id AS task_id,
    t.title,
    t.description,
    t.status_id 
FROM users u 
INNER JOIN tasks t ON u.id = t.user_id
WHERE t.status_id = 2;

-- Отримати користувачів та кількість їхніх завдань.
SELECT u.id, u.fullname, COUNT(t.id) AS total_tasks
FROM users u 
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id;