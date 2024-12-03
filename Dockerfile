
FROM golang:1.22.0 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main .

FROM alpine:latest

RUN apk --no-cache add ca-certificates sqlite

COPY --from=builder /app/main .

CMD ["./main"]

EXPOSE 8080