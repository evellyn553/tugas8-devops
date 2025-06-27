<?php
require_once __DIR__ . '/../src/functions.php'; // Memuat file functions.php

$name = "Dunia";
if (isset($_GET['name'])) {
    $name = htmlspecialchars($_GET['name']); // Sanitize input
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Halo, <?php echo $name; ?></title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; background-color: #f0f8ff; color: #333; }
        h1 { color: #0056b3; }
    </style>
</head>
<body>
    <h1>Halo, <?php echo greet($name); ?>!</h1>
    <p>Aplikasi PHP sederhana Anda berjalan di Docker.</p>
    <p>Versi PHP: <?php echo phpversion(); ?></p>
</body>
</html>