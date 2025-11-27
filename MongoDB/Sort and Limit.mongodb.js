// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use("OIC");

//sort as per age
db.lecturers.find().sort({age: 1})//ascending order

db.lecturers.find().sort({age: -1})//descending order


//limit the document return
db.lecturers.find().limit(1);


//short with  limit ; ascending sort with limit for 1 document
db.lecturers.find().sort({age: 1}).limit(1);