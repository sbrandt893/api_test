<?php
class Event
{
    private $conn;

    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    public function addEvent($date, $title, $description)
    {
        $stmt = $this->conn->prepare("INSERT INTO events (date, title, description) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $date, $title, $description);
        if ($stmt->execute()) {
            $id = $this->conn->insert_id;
            return array("id" => $id, "date" => $date, "title" => $title, "description" => $description);
        } else {
            return array("error" => "Error adding event: " . $this->conn->error);
        }
    }

    public function getEvents($date)
    {
        $stmt = $this->conn->prepare("SELECT * FROM events WHERE date = ?");
        $stmt->bind_param("s", $date);
        $stmt->execute();
        $result = $stmt->get_result();
        $events = array();
        while ($row = $result->fetch_assoc()) {
            $events[] = $row;
        }
        return $events;
    }

    public function deleteEventById($id)
    {
        $stmt = $this->conn->prepare("DELETE FROM events WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        if ($stmt->affected_rows > 0) {
            return array("success" => true, "message" => "Event with ID $id was deleted successfully.");
        } else {
            return array("success" => false, "message" => "No event found with ID $id.");
        }
    }

    public function getEventById($id)
    {
        $stmt = $this->conn->prepare("SELECT * FROM events WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows > 0) {
            return $result->fetch_assoc();
        } else {
            return array("error" => "No event found with ID $id.");
        }
    }

    public function updateEventById($id, $date, $title, $description)
    {
        $stmt = $this->conn->prepare("UPDATE events SET date = ?, title = ?, description = ? WHERE id = ?");
        $stmt->bind_param("sssi", $date, $title, $description, $id);
        if ($stmt->execute()) {
            return array("id" => $id, "date" => $date, "title" => $title, "description" => $description);
        } else {
            return array("error" => "Error updating event: " . $this->conn->error);
        }
    }

    public function getAllEvents()
    {
        $stmt = $this->conn->prepare("SELECT * FROM events");
        $stmt->execute();
        $result = $stmt->get_result();
        $events = array();
        while ($row = $result->fetch_assoc()) {
            $events[] = $row;
        }
        return $events;
    }
}