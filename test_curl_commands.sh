#!/bin/bash

# Test script for Django Bulk DRF upsert functionality
# Replace these variables with your actual values

BASE_URL="http://localhost:8000/api"  # Change to your actual URL
TOKEN="e01c4980d4c9cb314433d29af30195bff01146c4"
MODEL_ENDPOINT="financial-transactions"  # Change to your actual model endpoint

echo "🧪 Testing Django Bulk DRF Upsert Functionality"
echo "================================================"

# Test 1: Salesforce-style upsert with array data
echo "
📝 Test 1: Salesforce-style Bulk Upsert (Array Data)"
echo "----------------------------------------------------"

curl -X PATCH "${BASE_URL}/${MODEL_ENDPOINT}/bulk/?unique_fields=financial_account,datetime" \
  -H "Authorization: Token ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '[
    {
      "amount": "100.50",
      "description": "Test upsert transaction 1", 
      "datetime": "2025-01-01T10:00:00Z",
      "financial_account": 1,
      "classification_status": 1
    },
    {
      "amount": "200.75",
      "description": "Test upsert transaction 2",
      "datetime": "2025-01-01T11:00:00Z", 
      "financial_account": 1,
      "classification_status": 1
    }
  ]'

echo -e "\n"

# Test 2: Salesforce-style upsert with single object
echo "📝 Test 2: Salesforce-style Single Object Upsert"
echo "--------------------------------------------------"

curl -X PATCH "${BASE_URL}/${MODEL_ENDPOINT}/bulk/?unique_fields=financial_account,datetime" \
  -H "Authorization: Token ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": "999.99",
    "description": "Single test upsert transaction",
    "datetime": "2025-01-01T14:00:00Z",
    "financial_account": 1,
    "classification_status": 1
  }'

echo -e "\n"

# Test 3: Legacy-style upsert (backward compatibility)
echo "📝 Test 3: Legacy-style Bulk Upsert (Backward Compatibility)"
echo "-------------------------------------------------------------"

curl -X PATCH "${BASE_URL}/${MODEL_ENDPOINT}/bulk/" \
  -H "Authorization: Token ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "data": [
      {
        "amount": "150.00",
        "description": "Legacy upsert transaction 1",
        "datetime": "2025-01-01T12:00:00Z",
        "financial_account": 1,
        "classification_status": 1
      },
      {
        "amount": "250.00", 
        "description": "Legacy upsert transaction 2",
        "datetime": "2025-01-01T13:00:00Z",
        "financial_account": 1,
        "classification_status": 1
      }
    ],
    "unique_fields": ["financial_account", "datetime"]
  }'

echo -e "\n"

# Test 4: PUT method upsert (full replacement style)
echo "📝 Test 4: PUT Method Upsert (Full Replacement)"
echo "------------------------------------------------"

curl -X PUT "${BASE_URL}/${MODEL_ENDPOINT}/bulk/?unique_fields=financial_account,datetime" \
  -H "Authorization: Token ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '[
    {
      "amount": "300.00",
      "description": "PUT upsert transaction 1",
      "datetime": "2025-01-01T15:00:00Z",
      "financial_account": 1,
      "classification_status": 1
    }
  ]'

echo -e "\n"

# Test 5: Check status of a task (replace TASK_ID with actual task ID from above)
echo "📝 Test 5: Check Task Status"
echo "-----------------------------"
echo "To check status, replace TASK_ID with actual task ID from above responses:"
echo "curl -X GET \"${BASE_URL}/bulk-operations/TASK_ID/status/\" -H \"Authorization: Token ${TOKEN}\""

echo -e "\n"

# Test 6: CSV Upsert example
echo "📝 Test 6: CSV Upsert Example"
echo "------------------------------"
echo "Create a CSV file (sample.csv) with headers: amount,description,datetime,financial_account,classification_status"
echo "Then run:"
echo "curl -X PATCH \"${BASE_URL}/${MODEL_ENDPOINT}/bulk/\" \\"
echo "  -H \"Authorization: Token ${TOKEN}\" \\"
echo "  -F \"file=@sample.csv\" \\"
echo "  -F \"unique_fields=financial_account,datetime\""

echo -e "\n"

# Test 7: Verify query parameters show in OpenAPI/Swagger docs
echo "📝 Test 7: Check OpenAPI Schema"
echo "--------------------------------"
echo "To verify query parameters appear in Swagger docs, visit:"
echo "${BASE_URL}/docs/"
echo "Or check the OpenAPI schema at:"
echo "${BASE_URL}/schema/"

echo -e "\n"
echo "✅ Test commands generated!"
echo "📋 Remember to:"
echo "   1. Replace BASE_URL with your actual API URL"
echo "   2. Replace MODEL_ENDPOINT with your actual model endpoint"
echo "   3. Adjust field names and values according to your model"
echo "   4. Ensure your Django server is running"
echo "   5. Ensure Celery workers are running" 