const express = require("express");
const app = express();
const PORT = process.env.PORT || 5001;
var cors = require("cors");

app.use(cors());

// Health check endpoint
app.get("/health", (req, res) => {
  console.log('Health check called at:', new Date().toISOString());
  res.status(200).json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    service: 'backend-api'
  });
});

app.get("/api/data", (req, res) => {
  res.json({ message: "Hello from anupsharma backend! " });
});

app.get("/api/status", (req, res) => {
  res.send("Backend is up. Try /api/data for DB message.");
});

app.listen(PORT, () => {
  console.log(`✅ Backend server running on port ${PORT}`);
  console.log(`✅ Health endpoint available at http://localhost:${PORT}/health`);
  console.log(`✅ API status at http://localhost:${PORT}/api/status`);
});

// Handle graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down gracefully');
  process.exit(0);
});