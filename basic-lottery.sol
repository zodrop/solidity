// SPDX-License-Identifier: MIT

pragma solidity >=0.8.4 <=0.9.0;


contract lottery {
    
address public manager;
address payable public winner;
address payable[] public players;

constructor() {
    manager = msg.sender;
    } 

// function buyTicket(uint256 _amount) public payable  {
//         require(_amount == 1 ether, "invalid amount. Pay 1 ether");
        
//             for (uint i = 0; i < players.length; i++){
//                 if (players[i] == address(0)) continue;
                
//                 // If player already exists in array skip adding
//                 if (msg.sender == players[i]) {
//                     revert("Player Already Exists. Wait for results");  
//                 }}
//                  addPlayer();
//                 }

function buyTicket() public payable  {
        require(msg.value==1 ether, "invalid amount. Pay 1 ether");
        
            for (uint i = 0; i < players.length; i++){
                if (players[i] == address(0)) continue;
                
                // If player already exists in array skip adding
                if (msg.sender == players[i]) {
                    revert("Player Already Exists. Wait for results");  
                }}
                 addPlayer();
                }

             
function getBalance() public  view returns (uint256)  {
    require(msg.sender==manager, "caller is not manager");
    return address(this).balance;
}

function random () internal view returns (uint256)   {
    return uint256(keccak256(abi.encodePacked(block.prevrandao, block.timestamp))); 
}

function addPlayer() internal {
        players.push(payable (msg.sender));
}

// function addPlayer(address _playerAddress) external  {
//     require (msg.sender==manager,"caller is not manager");
//      players.push(_playerAddress);
// }

// function removePlayers(uint256 _index) external   {
// require (_index < players.length, "invalid index");
// players [_index] = address(0); }   
    
function restartLottery() internal   {
players = new address payable[](0);
 } 
    
function pickWinner() public payable {
      require (msg.sender==manager,"caller is not manager");
      require(players.length >=3, "players less than 3");

      uint _randomNumber = random();
    uint256 r  = _randomNumber%players.length;
    winner = players[r];
    winner.transfer(getBalance());
    players = new address payable[](0);
}

}//close contract

