#### ND0277 - Data Engineering with Microsoft Azure

# Project 3: Building an Azure Data Lake


## Prerequisites

This project is set up on top of the python tooling of [Astral.sh](https://astral.sh/), escpecially their package manager `uv`. If you have it already installed you can set up this project and install all dependencies by running the following command inside the root folder.

```
uv sync
``` 

Otherwise you can find a quick install guide in this [documentation](https://docs.astral.sh/).

## Follow Along

In order to provide proof of my own work and to make following along this document easier, I recorded all steps in Azure and uploaded a cut version of it as an unlisted video to Youtube.

[![Watch step by step](images/video_thumbnail.png)](https://www.youtube.com/watch?v=alq_SW7osjo)


Below you can find markers for the different steps for easier navigation.

[0:05 Open Databricks and enable DBFS](https://www.youtube.com/watch?v=alq_SW7osjo&t=5s)  
[0:39 Create a Compute cluster](https://www.youtube.com/watch?v=alq_SW7osjo&t=39s)  
[1:27 Uploading CSV files](https://www.youtube.com/watch?v=alq_SW7osjo&t=87s)  
[2:00 Creating a Notebook and attaching Compute cluster](https://www.youtube.com/watch?v=alq_SW7osjo&t=120s)  
[2:27 ELT Notebook](https://www.youtube.com/watch?v=alq_SW7osjo&t=147s)

# Submission Notebooks

There are two Jupyter Notebooks included in this project. The [Local.ipynb](Local.ipynb) contains the coded for local testing while the [Azure.ipynb](Azure.ipynb) is exported from the actual Azure Databricks workspace. For convenience an [HTML version](Azure_HTML.html) is also attached.


# Star Schema 

As a first step I am going to transform the structure of the provided Divvy Dataset (see screenshot below) into a star schema. The entity `Account` is not provided in the dataset files for this project so it will not be covered in the DWH schema.

![alt text](images/divvy_db.png)

In the following I will describe the star schema with respect to given business requirements.

![alt text](images/star_schema_diagram.png)

**Time spent based on date/time factors:**
For this the `Fact_Trip` table can be combined with the dimensions `Dim_Date` and `Dim_Time`.

**Time spent based on start/end station:**
For this the `Fact_Trip` table can be combined with the dimension `Dim_Station`.

**Time spent based on riders age:**
This can be done by only using the `Fact_Trip` table as it holds the age of the rider at the trip time in an indexed column. Transforming this into its own dimension would be overhead as the foreign key would need an index anyways.

**Time spent based on membership status of the rider:**
For this the `Fact_Trip` table can be combined with the dimension `Dim_Rider` which holds a boolean flag for this.

**Money spent per month/quarter/year:**
For this the `Fact_Payment` table can be combined with the dimension `Dim_Date`.

**Money spent based on rider signup age:**
For this the `Fact_Payment` table can be combined with the dimension `Dim_Rider`. The age at signup is implicitly given by `birthday` and `account_start_date`.

**Money spent per member based on avg. rides/minutes per month**
Here it is possible to join the member riders from `Dim_Rider` with the `Fact_Trip` and aggregate on the `duration` or count and group by the month and filtered for a given threshold. Afterwards this can be joined with the `Fact_Payment` table and summed up by rider.
