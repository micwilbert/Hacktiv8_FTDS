# Step 2: Authentication
from google.colab import auth
auth.authenticate_user()
print('Authenticated')

# Step 3: Set up BigQuery client
from google.cloud import bigquery

project_id = "hacktiv8lc2latihan"
client = bigquery.Client(project=project_id)

print(f'Client created using project: {project_id}')
