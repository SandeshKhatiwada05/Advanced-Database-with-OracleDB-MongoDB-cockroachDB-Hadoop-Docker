// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use("OIC");

// This command shows collections
db.createCollection("Student");


//insert one
db.lecturers.insertOne({id:100, name: "Sandesh Khatiwada", course : ["TOC", "DBMS"]}) ;

//view
db.lecturers.find().pretty()

//insert many
db.lecturers.insertMany([{ID:200 ,name: "Dhiraj", salary: 100000}, 
                        {ID:201, name: "Sandesh", salary: 2200}, 
                        {ID:202, name: "Rajesh", salary:null, phone: 9812344555},
                        {ID:203, name: "Radha", salary: 90000, age: 35},
                        {ID:204, name: "Bikash", salary: 75000, age: 28}])


// Find the list of lecturers whose salary is greater than 80000
//$gt, $lt, $gte, $lte, $eq, $nq
db.lecturers.find({salary: {$gt: 80000}}, {name: true, salary: true, _id: false}) 

//Find the list of salary whose salary is less than 9000 and greater than 80000
db.lecturers.find({
  salary: {$gt: 80000, $lt: 90000}
}, {name: true, salary: true, _id: false})


//sort
db.lecturers.find({name: "Sandesh"})


//update
//update one
db.lecturers.updateOne(
  {name: "Sandesh"}, 
  {$set: {salary: 95000}}
)

//update many
db.lecturers.updateMany(
  {}, 
  {$set: {department:  "Computer Science"}}
)

// Verify
db.lecturers.find().pretty()

//delete document
db.lecturers.deleteOne({_id: ObjectId('693d345b84598ee3dbfb4c84')})


//delete many
db.lecturers.deleteMany({ID: {$in: [201, 202, 204]}})

//verify deletion
db.lecturers.find().pretty()