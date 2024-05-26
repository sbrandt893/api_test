<?php
require_once 'dbconfig.php';
require_once 'event.php';

// create new Event object for database operations
$event = new Event($conn);

// read action from GET parameter
$action = $_GET['action'] ?? null;

// perform action based on action type
switch ($action) {
    case 'addEvent':
        $data = json_decode(file_get_contents("php://input"), true);
        if (isset($data['date']) && isset($data['title']) && isset($data['description'])) {
            $date = $data['date'];
            $title = $data['title'];
            $description = $data['description'];
            $result = $event->addEvent($date, $title, $description);
            echo json_encode($result);
        } else {
            echo json_encode(array("error" => "Invalid data."));
        }
        break;

    case 'getEventsForDate':
        if (isset($_GET['date'])) {
            $date = $_GET['date'];
            $events = $event->getEvents($date);
            echo json_encode($events);
        } else {
            echo json_encode(array("error" => "Please provide a date."));
        }
        break;

    case 'deleteEventById':
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
            echo json_encode($event->deleteEventById($id));
        } else {
            echo json_encode(array("error" => "ID not provided."));
        }
        break;

    case 'getEventById':
        if (isset($_GET['id'])) {
            $id = $_GET['id'];
            echo json_encode($event->getEventById($id));
        } else {
            echo json_encode(array("error" => "ID not provided."));
        }
        break;

    case 'updateEventById':
        $data = json_decode(file_get_contents("php://input"), true);
        if (isset($data['id']) && isset($data['date']) && isset($data['title']) && isset($data['description'])) {
            $id = $data['id'];
            $date = $data['date'];
            $title = $data['title'];
            $description = $data['description'];
            $result = $event->updateEventById($id, $date, $title, $description);
            echo json_encode($result);
        } else {
            echo json_encode(array("error" => "Invalid data."));
        }
        break;

    case 'getAllEvents':
        $events = $event->getAllEvents();
        echo json_encode($events);
        break;

    default:
        echo json_encode(array("error" => "Invalid action."));
        break;
}

// close database connection
$conn->close();