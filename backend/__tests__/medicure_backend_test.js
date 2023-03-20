const app = require('../app');
const request = require('supertest');

describe('register new user', () => {
  it('should register a new user', async () => {
    const res = await request(app)
      .post('/api/user/register')
      .send({ name: 'test', email: 'test@gmail.com', password: '123' });
    expect(res.body.success).toEqual(true);
    expect(res.body.alreadyRegistered).toEqual(true);
  });
});

describe('register new user', () => {
  it('should register a new user', async () => {
    const res = await request(app)
      .post('/api/user/register')
      .send({ name: 'test2', email: 'test2@gmail.com', password: '123' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(true);
    expect(res.body.alreadyRegistered).toEqual(true);
  });
});

describe('user login with valid email and password', () => {
  it('user should be able to login', async () => {
    const res = await request(app)
      .post('/api/user/login')
      .send({ email: 'test@gmail.com', password: '123456' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(true);
    expect(res.body.userID).toEqual(2);
  });
});

describe('user login with valid email and password', () => {
  it('user should be able to login', async () => {
    const res = await request(app)
      .post('/api/user/login')
      .send({ email: 'test2@gmail.com', password: '123' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(true);
    expect(res.body.userID).toEqual(7);
  });
});

describe('user login with invalid email and password', () => {
  it('user should not be able to login', async () => {
    const res = await request(app)
      .post('/api/user/login')
      .send({ email: 'invalid@gmail.com', password: '123456' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(false);
  });
});

describe('user login with invalid email and password', () => {
  it('user should not be able to login', async () => {
    const res = await request(app)
      .post('/api/user/login')
      .send({ email: 'invalid2@gmail.com', password: '123456' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(false);
  });
});

describe('retrieve test history', () => {
  it("should return user's test history", async () => {
    const res = await request(app)
      .post('/api/chd_prediction/history')
      .send({ userID: '2' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(true);
  });
});

describe('retrieve test history', () => {
  it("should return user's data rows", async () => {
    const res = await request(app)
      .post('/api/chd_prediction/history')
      .send({ userID: '2' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(true);
    expect(res.body.result.length >= 0).toBeTruthy();
  });
});

describe('retrieve test history', () => {
  it('should return empty list', async () => {
    const res = await request(app)
      .post('/api/chd_prediction/history')
      .send({ userID: '50' });
    expect(res.statusCode).toEqual(200);
    expect(res.body.success).toEqual(true);
    expect(res.body.result.length === 0).toBeTruthy();
  });
});
