<?php

$successMessage = flash('success');
$errorMessage = flash('error');

?>
<!DOCTYPE html>
<html lang="id">
<head>
    <?php require __DIR__ . '/../components/head.php'; ?>
</head>

<body class="layout-<?= e($layout ?? 'error') ?>">

<?php if ($layout === 'admin'): ?>

    <div class="app-shell">
        <?php require __DIR__ . '/../components/sidebar.php'; ?>

        <div class="sidebar-overlay" id="sidebarOverlay"></div>

        <div class="app-main">
            <?php require __DIR__ . '/../components/navbar.php'; ?>

            <main class="page-content">
                <?php if ($successMessage): ?>
                    <div class="alert alert-success">
                        <?= e($successMessage) ?>
                    </div>
                <?php endif; ?>

                <?php if ($errorMessage): ?>
                    <div class="alert alert-danger">
                        <?= e($errorMessage) ?>
                    </div>
                <?php endif; ?>

                <?php require $pagePath ?? 'error'; ?>
            </main>

            <?php require __DIR__ . '/../components/footer.php'; ?>
        </div>
    </div>

<?php elseif ( $layout == 'guest'): ?>

    <?php if ($successMessage || $errorMessage): ?>
        <div class="global-alerts">
            <?php if ($successMessage): ?>
                <div class="alert alert-success">
                    <?= e($successMessage) ?>
                </div>
            <?php endif; ?>

            <?php if ($errorMessage): ?>
                <div class="alert alert-danger">
                    <?= e($errorMessage) ?>
                </div>
            <?php endif; ?>
        </div>
    <?php endif; ?>

    <?php require $pagePath ?? 'error'; ?>

    <?php if ($layout ?? null !== 'login'): ?>
        <?php require __DIR__ . '/../components/footer.php'; ?>
    <?php endif; ?>

<?php elseif ( $layout == 'login'): ?>

    <?php if ($successMessage || $errorMessage): ?>
        <div class="global-alerts">
            <?php if ($successMessage): ?>
                <div class="alert alert-success">
                    <?= e($successMessage) ?>
                </div>
            <?php endif; ?>

            <?php if ($errorMessage): ?>
                <div class="alert alert-danger">
                    <?= e($errorMessage) ?>
                </div>
            <?php endif; ?>
        </div>
    <?php endif; ?>

    <?php require $pagePath ?? 'error'; ?>

    <?php if ($layout ?? null !== 'login'): ?>
        <?php require __DIR__ . '/../components/footer.php'; ?>
    <?php endif; ?>
<?php endif; ?>


<script src="<?= e(url('/public/assets/js/script.js')) ?>"></script>
</body>
</html>