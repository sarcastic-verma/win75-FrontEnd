const base = 'http://10.0.2.2:5000/api/';
const gameBase = base + 'game/';
const transactionBase = base + 'transaction/';
const userBase = base + 'users/';
const windowBase = base + 'window/';
const playerSummaryBase = base + 'playerSummary/';

/////////////////Game Routes//////////////////

const getGameByIdCa = gameBase;
const getGamesByUserIdCa = gameBase + 'user/';
const endGameCa = gameBase + 'endgame/';
///////////////Transaction Routes////////////////

const addMoneyCa = transactionBase + 'add';
const redeemMoneyCa = transactionBase + 'redeem';
///////////////Users Routes////////////////////

const getUsers = userBase;
const getUserById = userBase;
const signUp = userBase + 'signup/';
const logIn = userBase + 'login/';
const forgotPassword = userBase + 'forgotPassword/';
const editUserCa = userBase + 'edit/';
const getLeaderBoard = userBase + 'leaderBoard';
const changePassword = userBase + 'changePassword';
//////////////Window Routes///////////////////

const getEventWindow = windowBase;
////////////player summary Routes/////////////

const updatePlayerSummary = playerSummaryBase + 'updatePlayerSummary/';
const getPlayerSummaryCa = playerSummaryBase;
const makePlayerSummaryCa = playerSummaryBase + 'makePlayerSummary/';
