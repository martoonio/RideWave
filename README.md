# RIDEWAVE
RideWave adalah perangkat lunak berbasis web app yang menyediakan layanan ride-sharing berbayar khusus untuk mahasiswa. Aplikasi ini dirancang untuk mengoptimalkan penggunaan kendaraan mahasiswa, mengurangi kemacetan, dan memfasilitasi interaksi sosial di antara mereka. 

## Cara menjalankan aplikasi:
1. Git Clone
2. Terminal -> flutter pub get
3. flutter run

## Use Case Implementasi:
1. Signup <br />
Penanggung jawab: Muhammad Mumtaz - 18221029

2. Login <br />
Penanggung jawab:Eleanora Felicia - 18221032 

3. Receive an order <br />
Penanggung jawab:Farchan Martha Adji Chandra - 18221011 

4. Order <br />
Penanggung jawab:Farchan Martha Adji Chandra - 18221011 

5. Report problem issue <br />
Penanggung jawab:Nabilah Amanda Putri - 18221021 

6. View history <br />
Penanggung jawab:Eleanora Felicia - 18221032 

7. Rate the rider <br />
Penanggung jawab:Nabilah Amanda Putri - 18221021 

8. Chatting <br />
Penanggung jawab:Muhammad Mumtaz - 18221029 


## Tabel Basis Data
### Tabel User 
Column | Attribute
------ | ---------
name | String
id | String
email | String
faculty | String
phone | String
password | String
blockStatus | Boolean

### Tabel Riders
Column | Attribute
------ | ---------
name | String
id | String
email | String
faculty | String
phone | String
password | String
blockStatus | Boolean
earnings | Integer
newTripStatus | String
photo | String
vehicle_details {} | String

### Tabel vehicle_details 
Column | Attribute
------ | ---------
vehicleColor | String
vehicleModel | String
vehicleNumber | String

### Tabel activeRiders
Column | Attribute
------ | ---------
activeStatus | Boolean

### Tabel tripRequests
Column | Attribute
------ | ---------
dropOffAddress | String
dropOffLatLng {} | Double
fareAmount | Double
pickUpAddress | String
pickUpLatLng {} | Double
publishDateTime | Date
riderID | String
riderLocation {} | Double
riderName | String
riderPhone | String
riderPhoto | String
status | String
tripID | String
userID | String
userName | String
userPhone | String
userPhoto | String
vehicle_details {} | String

### Tabel dropOffLatLng
Column | Attribute
------ | ---------
latitude | Double
longitude | Double

### Tabel pickUpLatLng
Column | Attribute
------ | ---------
latitude | Double
longitude | Double

### Tabel riderLocation
Column | Attribute
------ | ---------
latitude | Double
longitude | Double

### Tabel Messages
Column | Attribute
------ | ---------
message | String
receiverID | String
senderEmail | String
senderID | String
timestamp | Date

### Tabel report
Column | Attribute
------ | ---------
reportType | String
reportDescription | String

### Tabel rating
Column | Attribute
------ | ---------
users | String
rating | Integer
ratingDescription | String

## Unit Testing
https://docs.google.com/document/d/1JhgU_pjXk5zVTASknlqt1b_c_8mF9AjfCtgv_nUScTE/edit?usp=sharing