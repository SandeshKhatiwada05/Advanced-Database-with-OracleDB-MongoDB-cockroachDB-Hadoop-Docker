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



//few document
db.lecturers.find()


