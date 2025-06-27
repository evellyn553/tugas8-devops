<?php
// tests/functionsTest.php

use PHPUnit\Framework\TestCase;

require_once __DIR__ . '/../src/functions.php'; // Memuat fungsi yang akan diuji

class FunctionsTest extends TestCase
{
    public function testAdd()
    {
        $this->assertEquals(4, add(2, 2));
        $this->assertEquals(0, add(-1, 1));
        $this->assertEquals(10, add(3, 7));
    }

    public function testGreet()
    {
        $this->assertEquals("Halo, Dunia", greet("Dunia"));
        $this->assertEquals("Halo, Alice", greet("Alice"));
    }
}