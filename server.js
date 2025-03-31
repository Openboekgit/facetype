// server.js
const express = require('express');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json({ limit: '2mb' }));

app.post('/generate-svg', (req, res) => {
  const mfCode = req.body.mf;
  const uploadDir = path.join(__dirname, 'uploads');
  if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir);

  const mfPath = path.join(uploadDir, 'font.mf');
  const pePath = path.join(uploadDir, 'generate.pe');
  const svgPath = path.join(uploadDir, 'A.svg');

  // Write .mf and .pe files
  fs.writeFileSync(mfPath, mfCode);
  fs.writeFileSync(pePath, 'Open("font.pfb"); Select("A"); Export("A.svg"); Quit();');

  // Execute conversion: .mf → .pfb → .svg
  const cmd = `cd ${uploadDir} && mf2pt1 font.mf && fontforge -script generate.pe`;
  exec(cmd, (err, stdout, stderr) => {
    if (err) {
      console.error('Error:', stderr);
      return res.status(500).send('Font generation failed');
    }
    if (!fs.existsSync(svgPath)) {
      return res.status(500).send('SVG file not generated');
    }
    res.sendFile(svgPath);
  });
});

app.listen(port, () => {
  console.log(`Font Transform API running at http://localhost:${port}`);
});