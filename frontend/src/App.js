import React, { useEffect, useState } from "react";

function App() {
  const [data, setData] = useState("");

  useEffect(() => {
    // Use relative path instead of localhost:5001
    fetch("/api/data")
      .then((res) => res.json())
      .then((json) => setData(json.message))
      .catch((err) => {
        console.error("API Error:", err);
        setData("I am Anup Sharma Created This Frontend");
      });
  }, []);

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h1>Fullstack App with Docker</h1>
      <p>Message from backend: {data}</p>
    </div>
  );
}

export default App;