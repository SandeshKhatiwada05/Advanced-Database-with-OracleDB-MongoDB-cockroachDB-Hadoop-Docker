//Sandesh Khatiwada 28936
use("OIC");

// db.customer.drop();

//insert data
db.customer.insertMany([
    { _id: 101, name: "Sandesh", age: 23, city: "Sindhuli" },
    { _id: 111, name: "Saisa", age: 22, city: "Pokhara" },
    { _id: 119, name: "Dhiraj", age: 30, city: "Biratnagar" }
])


db.customer.find()

// 1. Find the id and name of the customer whose age is greater than 20 AND the city is Pokhara.
db.customer.find({
        $and: [
            { age: { $gt: 20 } },
            { city: "Pokhara" }
        ]},
    { _id: 1, name: 1 }
)


// 2. Find all customers who are either from Kathmandu or Sindhuli.
db.customer.find(
    {
        $or: [
            { city: "Kathmandu" },
            { city: "Sindhuli" }
        ]
    }
)
