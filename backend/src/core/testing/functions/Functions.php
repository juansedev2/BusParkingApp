<?php
// Functions to do testing in develop
function dd(mixed $variable){ // * dd -> die and dump
    return die(var_dump($variable));
}