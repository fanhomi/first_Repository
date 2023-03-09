// TODO comments
import express from "express";
import cors from "cors";
import caseRoute from "./routes/case_route";
import dataRoute from "./routes/data_route";
import model from "./model/router/test";


const app = express();

const port = 3456;

// cors
app.use(cors());


// parse application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: false }));
// parse application/json
app.use(express.json());

// Routes
// app.use("/case", caseRoute);
// app.use("/data", dataRoute);
app.use("/model", model);

app.listen(port, () => {
  console.log("http://localhost:3456");
});
