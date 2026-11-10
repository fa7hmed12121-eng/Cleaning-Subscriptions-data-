# Clean Subscriptions Using MySQL & Python

**Goal:** using Mysql Queries and Python functions to clean a very messy data 
 <h2>🔎 Data exploration</h2>

<table>
  <tr>
    <td width="50%">
      <p>There are non-standardize values in string columns<p>
        </p>There are empty values in some columns</p> <img width="1090" height="650" alt="Screenshot 2026-11-09 090040" src="https://github.com/user-attachments/assets/1d6c8d1c-0254-480c-8d54-4d684fd18478" />
<p>The Start_date column contain non-standarize date type </p> <img width="692" height="550" alt="Screenshot 2026-11-09 092221" src="https://github.com/user-attachments/assets/0b7c1134-5d14-4f1b-937a-6506ddc510d2"
    </td>
    <td width="50%" align="center">
      <p>The monthly_price column has Unreal valuses<p>
      <img <img width="1105" height="900" alt="Screenshot 2026-11-09 090620" src="https://github.com/user-attachments/assets/01d3209f-1304-4328-8584-8b0c0ce9fe6d"
 /> <p>There are some duplicate rows </p><img width="1080" height="750" alt="Screenshot 2026-11-09 091714" src="https://github.com/user-attachments/assets/c84626f6-2303-4902-a05d-2257ea6c1056" 
    </td>
  </tr>
</table>


# Data Cleaning 
- United Status, Plan, Country columns values to become Title Case type
  - remove the extra spaces in the values using **(trim)** function <img width="982" height="62" alt="Screenshot 2026-11-10 080605" src="https://github.com/user-attachments/assets/39fb95b6-e8f9-4bbd-9065-d7ab2d0dfde4" />
  - Using Cases to match values
- Fix Start_date column using **coalesce** function, because there is multiple dateframe, so it's use one frame **("Y%-m%-d%")** <img width="850" height="200" alt="Screenshot 2026-11-10 080841" src="https://github.com/user-attachments/assets/e174eb7a-74e1-4a89-beee-e955db7b2dd1" />
 
- Filling 'null' or empty rows in payment_method columns with 'Unknow' values using **Case**<img width="1355" height="165" alt="Screenshot 2026-11-10 081640" src="https://github.com/user-attachments/assets/7f5be8ca-f85a-480b-91bd-d9fd63813f20" />

- The subscriptions prices : 0.00 for FREE plan, 9.99 for Basic and 19.99 for Premium, So I use cases to create a new column instead <img width="770" height="220" alt="Screenshot 2026-11-10 082222" src="https://github.com/user-attachments/assets/2d604058-8e67-481e-b4ac-c7ecf6e6c07e" />

- Finally, Ranking the customers based on the last updated for get the least status , to git rid of duplicate rows <img width="1415" height="365" alt="Screenshot 2026-11-10 082723" src="https://github.com/user-attachments/assets/89639000-f00d-4851-b872-b23cd2a2fdce" />

## **I have use CTE to have final result in one code**
