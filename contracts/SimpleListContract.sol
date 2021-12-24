// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SimpleListContract {
    address[] public people;
    address[] private auxArray;


    function addPerson(address _address) public {
        people.push(_address);
    }

    function getPeople() public view returns(address[] memory){
        return people;
    }

    function removePerson(address _value) public{

    address[] memory emptyAddress;

    for (uint i = 0; i < people.length; i++){
        if (people[i] != _value){
            auxArray.push(people[i]);
        }  
    }
       people = auxArray;
       auxArray = emptyAddress;
    }

}

