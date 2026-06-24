<!DOCTYPE html>
<html lang="en">
    <?php require __DIR__ . '/../components/head.php' ?>
<body>
    <?php require __DIR__ . '/../components/navbar.php' ?>
    <?php require $content ?? './pages/dashboard.php' ?>
    
    <?php require __DIR__ . '/../components/footer.php' ?>
</body>
</html>