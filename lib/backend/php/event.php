//TODO: Implement the missing action methods for the database operations

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