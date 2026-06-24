<!DOCTYPE html>
<html lang="en">
    <?php require __DIR__ . '/../components/head.php' ?>
<body>
    <div>
        <?php require __DIR__ . "/../components/sidebar.php" ?>
        <div class="main-content">
            <?php require __DIR__ . '/../components/navbar.php' ?>
            <?php require $content ?? './pages/dashboard.php' ?>
            <?php require __DIR__ . '/../components/footer.php' ?>
        </div>
    </div>
</body>
</html>