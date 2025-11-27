// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use("OIC");

//delete one
db.lecturers.deleteOne({ _id: ObjectId("6927bbe97e50852cef27990e") })

// delete many via id
db.lecturers.deleteMany({ _id: 
                { $in: [ObjectId("6927bbe97e50852cef27990e"), 
                        ObjectId("6927bb34478fa0e80ad4c414"), 
                        ObjectId("6927bb34478fa0e80ad4c413")] } })


//inser one
db.lecturers.insertOne({
    teacher_number : 5,
    name : "Sandesh",
    age : 25
})


//different datatypes
db.lecturers.insertOne({
    name: "Mr SK", //string
    age: 23, //int
    gpa: 3.8, //double
    fullTime: false, //boolean
    register_date: new Date(), //current date
    contract_completion_date: null, //null as a placeholder for future
    courses: ["OOP", "Compiler", "Advanced Java"], //array
    address: {street: "APF", city: "Kathmandu", zip: 44006} //nested document 
})


//few document
db.lecturers.find()


