<?php
//this file and app.yaml is only used in GCP
//to tell the sever where to redirect
# [START gae_simple_front_controller]
switch (@parse_url($_SERVER['REQUEST_URI'])['path']) {
    case '/':
        require 'login.php';
        break;
    case '/login.php':
        require 'login.php';
        break;
    case '/register.php':
        require 'register.php';
        break;
    case '/login_form.css':
        require 'login_form.css';
        break;
    case '/verification.php':
        require 'verification.php';
        break;
    case '/test.php':
        require 'test.php';
        break;
    case '/forget_pwd.php':
        require 'forget_pwd.php';
        break;
    case '/welcome.php':
        require 'welcome.php';
        break;
    case '/img/log.png':
        require 'img/log.png';
        break;
    case '/img/exam.png':
        require 'img/exam.png';
        break;
    case '/img/edit.png':
        require 'img/edit.png';
        break;
    case '/new_test.php':
        require 'new_test.php';
        break;
    case '/intest.php':
        require 'intest.php';
        break;
    case '/create.php':
        require 'create.php';
        break;
    case '/view_log.php':
        require 'view_log.php';
        break;
    case '/view_question.php':
        require 'view_question.php';
        break;
    case '/redo.php':
        require 'redo.php';
        break;
    case '/resume.php':
        require 'resume.php';
        break;
    case '/combine.php':
        require 'combine.php';
        break;
    case '/combine_log.php':
        require 'combine_log.php';
        break; 
    case '/answer_handler.php':
        require 'answer_handler.php';
        break; 
    case '/get_question.php':
        require 'get_question.php';
        break; 
    case '/contact_us.php':
        require 'contact_us.php';
        break; 
    default:
        http_response_code(404);
        exit('Not Found');
}
?>