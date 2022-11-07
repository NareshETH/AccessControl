// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


contract AccessControl{

    event SetRole(bytes32 indexed role,
    address indexed account
    );
    
    event RevokeRole(bytes32 indexed role,
    address indexed account
    );

  mapping (bytes32 => mapping (address => bool))public  roles;

  //0x02016836a56b71f0d02689e69e326f4f4c1b9057164ef592671cf0d37c8040c0
  bytes32 private  constant OWNER = keccak256(abi.encodePacked("owner"));

  constructor(){
      _setRole(OWNER, msg.sender);
  }

  modifier onlyOwner(bytes32 _owner){
      require(roles[_owner][msg.sender],"you are not Owner");
      _;
  }


  function _setRole(bytes32 _role,
  address _account
  )internal{

     roles[_role][_account] = true;
     emit SetRole(_role, _account);

  }

  //setting the role only called by current OWNER
  function setRole(bytes32 _role,
  address _newOwner
  )external  onlyOwner(OWNER){

     _setRole(_role, _newOwner);
  }

  //revoke the current owner only called by newOwner
  function revokeRole(bytes32 _role,
  address _newOwner
  )external  onlyOwner(OWNER){
  
      roles[_role][_newOwner] = false;
      emit RevokeRole(_role, _newOwner);
  }


}
