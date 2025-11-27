// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use("OIC");

//.find({query}, {projection})

//find feature
db.lecturers.find({name: "Mr SK"}) //only query

db.lecturers.find({teacher_number: 5})

db.lecturers.find({age: 23, fullTime: false}) //double filter (even multiple filters can be used this way)

//return all the teachers but only give their name
db.lecturers.find({}, {name : true}) //{select}, {projection}


//it gives id by default so id can be set false
//return all the teachers but only give their name
db.lecturers.find({}, {name : true, _id : false}) //{select}, {projection}


db.lecturers.find()
