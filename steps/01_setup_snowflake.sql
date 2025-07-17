USE ROLE ACCOUNTADMIN;

CREATE OR ALTER WAREHOUSE THIM_WH 
  WAREHOUSE_SIZE = XSMALL 
  AUTO_SUSPEND = 300 
  AUTO_RESUME= TRUE;


-- Separate database for git repository
CREATE OR ALTER DATABASE EMP_{{environment}};


-- API integration is needed for GitHub integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/tmbothe') -- INSERT YOUR GITHUB USERNAME HERE
  ENABLED = TRUE;


-- Git repository object is similar to external stage
CREATE OR REPLACE GIT REPOSITORY emp_common.public.emp_repo
  API_INTEGRATION = git_api_integration
  ORIGIN = 'https://github.com/tmbothe/snowflake-devOps'; -- INSERT URL OF FORKED REPO HERE


CREATE OR ALTER DATABASE EMP_{{environment}}; 


-- To monitor data pipeline's completion
CREATE OR REPLACE NOTIFICATION INTEGRATION email_integration
  TYPE=EMAIL
  ENABLED=TRUE;


-- Database level objects
CREATE OR ALTER SCHEMA PRIVATE;
CREATE OR ALTER SCHEMA STAGING;
--CREATE OR ALTER SCHEMA PUBLIC;


-- Schema level objects
CREATE OR REPLACE FILE FORMAT PRIVATE.json_format TYPE = 'json';
CREATE OR ALTER STAGE PRIVATE.raw;
