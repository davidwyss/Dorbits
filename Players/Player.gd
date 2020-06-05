extends Node

var id
var rift
var nickname
var is_puppet

func init(_nickname, _is_puppet):
    $Name.text = nickname
    nickname = _nickname
    is_puppet = _is_puppet
