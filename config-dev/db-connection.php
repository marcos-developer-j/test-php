<?php

return new PDO("mysql:host=db;dbname=sample", "root", "samplepass", [PDO::ATTR_PERSISTENT => true]);
