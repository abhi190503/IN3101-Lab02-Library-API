package lk.ac.mrt.fit.library_api.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.List;
import java.util.Optional;

import lk.ac.mrt.fit.library_api.model.Book;
import lk.ac.mrt.fit.library_api.repository.BookRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class BookServiceTest {

    @Mock
    private BookRepository bookRepository;

    private BookService bookService;

    @BeforeEach
    void setUp() {
        bookService = new BookService(bookRepository);
    }

    @Test
    void getsAllBooks() {
        Book book = book("Clean Code", "Robert C. Martin", 4500.0);
        when(bookRepository.findAll()).thenReturn(List.of(book));

        assertEquals(List.of(book), bookService.getAllBooks());
    }

    @Test
    void updatesAnExistingBookWithoutChangingItsId() {
        Book existing = book("Old title", "Old author", 100.0);
        existing.setId(7L);
        Book details = book("New title", "New author", 200.0);
        when(bookRepository.findById(7L)).thenReturn(Optional.of(existing));
        when(bookRepository.save(existing)).thenReturn(existing);

        Optional<Book> updated = bookService.updateBook(7L, details);

        assertTrue(updated.isPresent());
        assertEquals(7L, updated.orElseThrow().getId());
        assertEquals("New title", updated.orElseThrow().getTitle());
    }

    @Test
    void returnsEmptyWhenUpdatingMissingBook() {
        when(bookRepository.findById(99L)).thenReturn(Optional.empty());

        assertTrue(bookService.updateBook(99L, book("Title", "Author", 0.0)).isEmpty());
    }

    @Test
    void deletesExistingBookAndReportsMissingBook() {
        Book existing = book("Title", "Author", 0.0);
        existing.setId(5L);
        when(bookRepository.findById(5L)).thenReturn(Optional.of(existing));
        when(bookRepository.findById(6L)).thenReturn(Optional.empty());

        assertTrue(bookService.deleteBook(5L));
        verify(bookRepository).delete(existing);
        assertFalse(bookService.deleteBook(6L));
    }

    private Book book(String title, String author, Double price) {
        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        book.setPrice(price);
        return book;
    }
}
