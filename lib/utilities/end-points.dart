const base = 'https://win75.herokuapp.com/api/';

const gameBase = base + 'game/';
const transactionBase = base + 'transaction/';
const userBase = base + 'users/';
const windowBase = base + 'window/';
const playerSummaryBase = base + 'playerSummary/';

/////////////////Game Routes//////////////////

const getGameByIdCa = gameBase + 'game/';
const getGamesByUserIdCa = gameBase + 'user/id';
const endGameNca = gameBase + 'endgame/';
///////////////Transaction Routes////////////////

const addMoneyCa = transactionBase + 'add';
const getTransactionByUserIdCa = transactionBase + 'getByUserId';
const redeemMoneyCa = transactionBase + 'redeem';
const realTransaction = transactionBase + 'realTransaction';
const addPointsCa = transactionBase + 'addPoints';
const reducePointsCa = transactionBase + 'reducePoints';
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
const getCurrentEventWindow = windowBase + 'getCurrentWindow/now';
////////////player summary Routes/////////////

const getPlayerSummaryCa = playerSummaryBase;
const makePlayerSummaryCa = playerSummaryBase + 'makePlayerSummary/';
