// MongoDB Playground
use("university");

// Drop existing collection to start fresh
// db.course.drop()

// 1.  Create collection
db.course.insertMany([
  {
    title: "Data Structures",
    prerequisite: "Introduction to Programming",
    total_grade: 100,
    fee: 5000
  },
  {
    title: "Database Management Systems",
    prerequisite: "Data Structures",
    total_grade: 100,
    fee: 6000
  },
  {
    title: "Operating Systems",
    prerequisite: "Computer Organization",
    total_grade: 100,
    fee: 5500
  },
  {
    title: "Web Development",
    prerequisite: null,
    total_grade: 100,
    fee: 4500
  },
  {
    title: "Machine Learning",
    prerequisite: "Linear Algebra",
    total_grade: 100,
    fee: 7000
  }
])

// 2. Find documents with fee >= 5000
db. course.find({ fee: { $gte: 5000 } })


//add credit hour using update
db.course.updateOne(
  { title: "Data Structures" },
  { $set: { credit_hour: 4 } }
)

db.course.updateOne(
  { title: "Database Management Systems" },
  { $set: { credit_hour: 3 } }
)

db.course. updateOne(
  { title: "Operating Systems" },
  { $set: { credit_hour: 3 } }
)

db.course.updateOne(
  { title: "Web Development" },
  { $set: { credit_hour: 2 } }
)

db.course. updateOne(
  { title: "Machine Learning" },
  { $set: { credit_hour: 4 } }
)

//Find the documents that has 4 credit hours
db.course.find({ credit_hour: 4 })


// 4.	Find the name and fee of the course of the last document
db.course.find({}, { title: 1, fee: 1, _id: 0 }). sort({ _id: -1 }). limit(1)


// 5. Find the info of datascience course
//insert first
db.course.insertOne(
    {
    title: "Data Science",
    prerequisite: "Statistics",
    total_grade: 200,
    fee: 12000
})

// view
db.course.find({title: "Data Science"})