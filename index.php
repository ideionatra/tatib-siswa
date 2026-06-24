<?php

$routes = require './routes/web.php';

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$route = $routes[$uri] ?? null;

if (!$route) {
    die('404');
}

$title = $route['title'];
$content = $route['page'];

require './public/index.php';